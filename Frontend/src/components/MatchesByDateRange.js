import React, { useState } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';

const MatchesByDateRange = () => {
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [matches, setMatches] = useState([]);

  const fetchMatches = () => {
    axios.get(`http://localhost:5288/api/Ipl/GetMatchesByDateRange?startDate=${startDate}&endDate=${endDate}`)
      .then(response => setMatches(response.data))
      .catch(error => console.error('Error fetching matches:', error));
  };

  return (
    <div className="container mt-4">
      <h2>Matches By Date Range</h2>
      <div className="form-group">
        <label>Start Date:</label>
        <input type="date" value={startDate} onChange={e => setStartDate(e.target.value)} className="form-control" />
      </div>
      <div className="form-group">
        <label>End Date:</label>
        <input type="date" value={endDate} onChange={e => setEndDate(e.target.value)} className="form-control" />
      </div>
      <button onClick={fetchMatches} className="btn btn-primary mt-3">Fetch Matches</button>

      <table className="table table-striped mt-4">
        <thead>
          <tr>
            <th>Match ID</th>
            <th>Date</th>
            <th>Venue</th>
            <th>Team 1</th>
            <th>Team 2</th>
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
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default MatchesByDateRange;
