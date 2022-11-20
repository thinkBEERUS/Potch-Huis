import '../index.css';
import { Link } from 'react-router-dom';
import useLocalStorage from 'use-local-storage';
import React, { useState, useEffect } from 'react';

function Register() {

  const [theme, setTheme] = useLocalStorage('theme' ? 'dark' : 'light')

  const switchTheme = () => {
    const newTheme = theme === 'light' ? 'dark' : 'light';
    setTheme(newTheme);
  }

  return (
    <div className="app" data-theme={theme}>
      <div className='login-container'>
        <h1>Login</h1>
        <div className='container'>
          <div className='top'>
          </div>
          <p className='divider'><span>Good Times & Lekker People</span></p>
          <form>
            <label>Member Number</label>
            <input type={'text'} placeholder='Member Number' />
            <label>Password</label>
            <input type={'password'} placeholder='Password' />
            <label>Confirm Password</label>
            <input type={'password'} placeholder='Confirm Password' />
            <label>Email</label>
            <input type={'email'} placeholder='something@gmail.com' />
            <label>WhatsApp Number</label>
            <input type={'tel'} placeholder='012 345 6789' />
            <Link to="/DocumentList" className="btn btn-success">Register</Link>
          </form>
        </div>
      </div>
    </div>
  );
}

export default Register;
