import './Login.css';
import Layout from '../Layout/Layout.js';
import { Link } from 'react-router-dom';

function Login() {
  return (
    <Layout bodyElements={
      <div className='body'>
      <div className='card'>        
        <div className='container'>
            <h1>Login</h1>
            <hr />
            <form>
              <input type="text" name="Member Number" placeholder='Member Number'/>
              <input type="password" name="Password" placeholder='Password'/>
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
