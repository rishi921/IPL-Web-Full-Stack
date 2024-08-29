import React from 'react';
import Navbar from './Navbar';
import 'bootstrap/dist/css/bootstrap.min.css';

const Home = () => {
  return (
    <>
      <nav className="navbar navbar-expand-lg navbar-light bg-light">
        <Navbar />
      </nav>
      <img
        className="d-block w-100"
        src="https://pbs.twimg.com/media/GBsB-L-aMAAX4gN.jpg" width="1100px" height="630px" alt="Banner"
      />
    </>
  );
};

export default Home;