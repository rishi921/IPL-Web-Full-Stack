import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';

const TopPlayers = () => {
  const [players, setPlayers] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:5288/api/Ipl/GetTopPlayers')
      .then(response => setPlayers(response.data))
      .catch(error => console.error('Error fetching top players:', error));
  }, []);

  return (
    <div className="container mt-4" style={{ backgroundColor: 'aliceblue', padding: '20px', borderRadius: '10px' }}>
      <h2 style={{ textAlign: 'center', marginBottom: '20px' }}>Top Players</h2>
      <table className="table table-striped table-bordered" style={{ backgroundColor: '#ffffff' }}>
        <thead className='thead-dark'>
          <tr>
            <th>Player ID</th>
            <th>Player Name</th>
            <th>Matches Played</th>
          </tr>
        </thead>
        <tbody>
          {players.map(player => (
            <tr key={player.playerId}>
              <td>{player.playerId}</td>
              <td>{player.playerName}</td>
              <td>{player.matchesPlayed}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default TopPlayers;
