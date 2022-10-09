import Layout from '../Layout/Layout.js';
import './Register.css';

function Register() {
  return (
    <Layout bodyElements={    
        <div class="body">
            <div class="card">        
                <div class="container">
                    <h1>Register</h1>
                    <hr />
                    <form>
                      <input type="text" name="Member Number" placeholder='Member Number'/>
                      <input type="password" name="Password" placeholder='Password'/>
                      <input type="password" name="Confirm Password" placeholder='Confirm Password'/>
                    </form>
                    <hr />
                    <p>By creating an account you agree to our <a href="#">Terms & Privacy</a>.</p>
                    <button type="submit" class="registerbtn">Register</button>
                    <div class="container signin">
                        <p>Already have an account? <a href="/Potch-Huis/Login">Sign in</a></p>
                    </div>
                </div>
            </div>
        </div>
    }>
    </Layout>
  );
}

export default Register;
