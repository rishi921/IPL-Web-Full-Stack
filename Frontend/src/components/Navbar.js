import React from 'react';
import { Link } from 'react-router-dom';
import '../styling/Navbar.css';

const Navbar = () => {
  return (
    <nav className="navbar-nav">
      <div className="navbar-logo-img">
        <img
          src="https://www.jagranimages.com/images/newimg/21082020/21_08_2020-ipl_logo_20650553.jpg" 
          // src="https://i.redd.it/d2v9lmyn7ir81.jpg"
          alt="Ipl Logo"
          className="navbar-logo-image"
        />
        <Link to="/" className="navbar-logo">IPL Web</Link>
      </div>
      <ul className="navbar-menu">
        <li><Link to="/home" className="navbar-item button-link">Home</Link></li>
        <li><Link to="/match-details" className="navbar-item button-link">Match Details</Link></li>
        <li><Link to="/top-players" className="navbar-item button-link">Top Players</Link></li>
        <li><Link to="/matches-by-date-range" className="navbar-item button-link">Matches By Date Range</Link></li>
        <li><Link to="/form" className="navbar-item button-link">Form</Link></li>
      </ul>
    </nav>
  );
};

export default Navbar;
