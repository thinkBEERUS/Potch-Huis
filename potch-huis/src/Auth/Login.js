import './Login.css';
import Layout from '../Layout/Layout.js';
import Button from 'react-bootstrap/Button';
import { Link } from 'react-router-dom';

function Login() {
  return (
    <Layout bodyElements={
      <div className='body'>
      <div className='card'>        
        <div className='container'>
            <h1>Login</h1>
            <p>Please fill in this form to Login</p>
            <hr />
            <form>
                <label>
                    Name:
                    <input type="text" name="Member Number" />
                </label>
                <label>
                    Password:
                    <input type="password" name="Password" />
                </label>
            </form>
            <hr />
            <p>We are glad to see you again</p>
            <Link to="/Dashboard" className="btn btn-success">Login</Link> 
            <div class="container signin">
                <p>Need an account? <Link to="/Register">Register</Link>.</p>
            </div>
        </div>
      </div>
    </div>
    }>
    </Layout>
  );
}

export default Login;
