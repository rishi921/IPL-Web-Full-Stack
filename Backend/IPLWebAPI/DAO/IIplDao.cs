using IPLWebAPI.Models;

namespace IPLWebAPI.DAO
{
    public interface IIplDao
    {
        Task<List<PlayerDto>> GetTopPlayers();
        Task<List<MatchStatisticsDto>> GetMatchStatistics();
        Task<List<MatchDto>> GetMatchesByDateRange(DateTime startDate, DateTime endDate);
        Task<bool> AddPlayer(Player player);
    }
}
