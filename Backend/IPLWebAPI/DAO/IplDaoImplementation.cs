using IPLWebAPI.Models;
using Npgsql;
using System.Data;

namespace IPLWebAPI.DAO
{
    public class IplDaoImplementation : IIplDao
    {
        NpgsqlConnection _connection;
        public IplDaoImplementation(NpgsqlConnection connection)
        {
            _connection = connection;
        }

        public async Task<List<PlayerDto>> GetTopPlayers()
        {
            string sql = @"
                    select p.player_id, p.player_name, p.matches_played
                    from Players p
                    join Matches m ON p.team_id IN (m.team1_id, m.team2_id)
                    join (
                        SELECT match_id, COUNT(*) AS engagement_count 
                        FROM Fan_Engagement 
                        GROUP BY match_id
                    ) fe ON m.match_id = fe.match_id
                    order by fe.engagement_count DESC, p.matches_played DESC
                    limit 5;";

            var cmd = new NpgsqlCommand(sql, _connection);
            var topPlayers = new List<PlayerDto>();

            if (_connection.State != ConnectionState.Open)
            {
                await _connection.OpenAsync();
            }

            using (var reader = await cmd.ExecuteReaderAsync())
            {
                while (await reader.ReadAsync())
                {
                    topPlayers.Add(new PlayerDto
                    {
                        PlayerId = reader.GetInt32(0),
                        PlayerName = reader.GetString(1),
                        MatchesPlayed = reader.GetInt32(2)
                    });
                }
            }

            return topPlayers;
        }

        public async Task<List<MatchStatisticsDto>> GetMatchStatistics()
        {
            string sql = @"
                select m.match_id, m.match_date, m.venue, t1.team_name AS team1_name, t2.team_name AS team2_name, 
                COALESCE(fe.engagement_count, 0) AS total_engagements
                from Matches m
                join Teams t1 ON m.team1_id = t1.team_id
                join Teams t2 ON m.team2_id = t2.team_id
                left join ( SELECT match_id, COUNT(*) AS engagement_count  FROM Fan_Engagement GROUP BY match_id ) fe ON m.match_id = fe.match_id;";

            var cmd = new NpgsqlCommand(sql, _connection);
            var matchStatistics = new List<MatchStatisticsDto>();

            if (_connection.State != ConnectionState.Open)
            {
                await _connection.OpenAsync();
            }

            using (var reader = await cmd.ExecuteReaderAsync())
            {
                while (await reader.ReadAsync())
                {
                    matchStatistics.Add(new MatchStatisticsDto
                    {
                        MatchId = reader.GetInt32(0),
                        MatchDate = reader.GetDateTime(1),
                        Venue = reader.GetString(2),
                        Team1Name = reader.GetString(3),
                        Team2Name = reader.GetString(4),
                        TotalEngagements = reader.GetInt32(5)
                    });
                }
            }

            return matchStatistics;
        }

        public async Task<List<MatchDto>> GetMatchesByDateRange(DateTime startDate, DateTime endDate)
        {
            string sql = @"
                    select m.match_id, m.match_date, m.venue, t1.team_name AS team1_name, t2.team_name AS team2_name
                    from Matches m
                    join Teams t1 on m.team1_id = t1.team_id
                    join Teams t2 on m.team2_id = t2.team_id
                    where m.match_date BETWEEN @startDate and @endDate;";

            var cmd = new NpgsqlCommand(sql, _connection);
            cmd.Parameters.AddWithValue("startDate", startDate);
            cmd.Parameters.AddWithValue("endDate", endDate);

            var matches = new List<MatchDto>();

            if (_connection.State != ConnectionState.Open)
            {
                await _connection.OpenAsync();
            }

            using (var reader = await cmd.ExecuteReaderAsync())
            {
                while (await reader.ReadAsync())
                {
                    matches.Add(new MatchDto
                    {
                        MatchId = reader.GetInt32(0),
                        MatchDate = reader.GetDateTime(1),
                        Venue = reader.GetString(2),
                        Team1Name = reader.GetString(3),
                        Team2Name = reader.GetString(4)
                    });
                }
            }

            return matches;
        }

        public async Task<bool> AddPlayer(Player player)
        {
            string sql = "INSERT INTO Players (player_name, team_id, role, age, matches_played) VALUES (@player_name, @team_id, @role, @age, @matches_played)";
            using var cmd = new NpgsqlCommand(sql, _connection);
            cmd.Parameters.AddWithValue("player_name", player.PlayerName);
            cmd.Parameters.AddWithValue("team_id", player.TeamId);
            cmd.Parameters.AddWithValue("role", player.Role);
            cmd.Parameters.AddWithValue("age", player.Age);
            cmd.Parameters.AddWithValue("matches_played", player.MatchesPlayed);

            if (_connection.State != ConnectionState.Open)
            {
                await _connection.OpenAsync();
            }

            int rowsAffected = await cmd.ExecuteNonQueryAsync();
            return rowsAffected > 0;
        }


    }
}
