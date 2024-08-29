import React, { useState } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';

const Form = () => {
  const [playerName, setPlayerName] = useState('');
  const [teamId, setTeamId] = useState('');
  const [role, setRole] = useState('');
  const [age, setAge] = useState('');
  const [matchesPlayed, setMatchesPlayed] = useState('');

  const addPlayer = () => {
    const playerData = { playerName, teamId, role, age, matchesPlayed };

    axios.post('http://localhost:5288/api/Ipl/AddPlayer', playerData)
      .then(response => alert('Player added successfully!'))
      .catch(error => console.error('Error adding player:', error));
  };

  return (
    <form className="container mt-4">
      <h2>Add Player</h2>
      <div className="form-group">
        <label>Player Name:</label>
        <input type="text" placeholder='Enter Player Name' value={playerName} onChange={e => setPlayerName(e.target.value)} className="form-control" />
      </div>
      <div className="form-group">
        <label>Team ID:</label>
        <input type="number" placeholder="Enter Player's Team Id" value={teamId} onChange={e => setTeamId(e.target.value)} className="form-control" />
      </div>
      <div className="form-group">
        <label>Role:</label>
        <input type="text" value={role} placeholder='Enter Player Role' onChange={e => setRole(e.target.value)} className="form-control" />
      </div>
      <div className="form-group">
        <label>Age:</label>
        <input type="number" value={age} placeholder="Enter Player's Age" onChange={e => setAge(e.target.value)} className="form-control" />
      </div>
      <div className="form-group">
        <label>Matches Played:</label>
        <input type="number" value={matchesPlayed} placeholder="Enter No. of Matches Player played" onChange={e => setMatchesPlayed(e.target.value)} className="form-control" />
      </div>
      <button onClick={addPlayer} className="btn btn-primary mt-3">Add Player</button>
    </form>
  );
};

// return (
//   <form className="add-match-form" onSubmit={handleSubmit}>
//       <div className="form-row">
//           <div className="form-group">
//               <label>Player 1 ID:</label>
//               <input
//                   type="number"
//                   name="player1Id"
//                   required
//                   value={formData.player1Id}
//                   placeholder='Enter Player 1 Id'
//                   onChange={handleChange}
//               />
//           </div>
//           <div className="form-group">
//               <label>Player 2 ID:</label>
//               <input
//                   type="number"
//                   name="player2Id"
//                   required
//                   value={formData.player2Id}
//                   placeholder='Enter Player 2 Id'
//                   onChange={handleChange}
//               />
//           </div>
//       </div>
//       <div className="form-group">
//           <label>Match Date:</label>
//           <input
//               type="date"
//               name="matchDate"
//               required
//               value={formData.matchDate}
//               onChange={handleChange}
//           />
//       </div>
//       <div className="form-group">
//           <label>Match Level:</label>
//           <input
//               type="text"
//               name="matchLevel"
//               required
//               value={formData.matchLevel}
//               placeholder='Enter Match Level'
//               onChange={handleChange}
//           />
//       </div>
//       <div className="form-group">
//           <label>Winner ID:</label>
//           <input
//               type="number"
//               name="winnerId"
//               required
//               value={formData.winnerId}
//               placeholder='Enter Winner Id'
//               onChange={handleChange}
//           />
//       </div>
//       <button type="submit">Submit</button>
//   </form>
// );
// };

export default Form;
