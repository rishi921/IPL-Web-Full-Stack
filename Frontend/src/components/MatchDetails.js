import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styling/MatchDetails.css'

const MatchDetails = () => {
  const [matches, setMatches] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:5288/api/Ipl/GetMatchStatistics')
      .then(response => setMatches(response.data))
      .catch(error => console.error('Error fetching match statistics:', error));
  }, []);

  return (
    <div className="container mt-4" style={{ backgroundColor: 'aqua', padding: '20px', borderRadius: '10px' }}>
      <h2 style={{ textAlign: 'center', marginBottom: '20px' }}>Match Statistics</h2>
      <table className="table table-striped table-bordered" style={{ backgroundColor: '#ffffff' }}>
        <thead className="thead-dark">
          <tr>
            <th>Match ID</th>
            <th>Date</th>
            <th>Venue</th>
            <th>Team 1</th>
            <th>Team 2</th>
            <th>Total Engagements</th>
          </tr>
        </thead>
        <tbody>
          {matches.map(match => (
            <tr key={match.matchId}>
              <td>{match.matchId}</td>
              <td>{new Date(match.matchDate).toLocaleDateString()}</td>
              <td>{match.venue}</td>
              <td>{match.team1Name}</td>
              <td>{match.team2Name}</td>
              <td>{match.totalEngagements}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default MatchDetails;
