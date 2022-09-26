import Layout from '../Layout/Layout.js';
import './Register.css';

function Register() {
  return (
    <Layout bodyElements={    
        <div class="body">
            <div class="card">        
                <div class="container">
                    <h1>Register</h1>
                    <p>Please fill in this form to create an account.</p>
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
                        <label>
                            ConfirmPassword:
                            <input type="password" name="Confirm Password" />
                        </label>
                    </form>
                    <hr />
                    <p>By creating an account you agree to our <a href="#">Terms & Privacy</a>.</p>
                    <button type="submit" class="registerbtn">Register</button>
                    <div class="container signin">
                        <p>Already have an account? <a href="/Login">Sign in</a></p>
                    </div>
                </div>
            </div>
        </div>
    }>
    </Layout>
  );
}

export default Register;
