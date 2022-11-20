import '../index.css';
import { Link } from 'react-router-dom';
import useLocalStorage from 'use-local-storage';

function Login() {

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
            <div className='remember'>
              <input type={'checkbox'} checked='checked' />
              <p>Remember Me</p>
            </div>
            <Link to="/Dashboard" className="btn btn-success">Login</Link>
          </form>
          <div>
            <Link to="/PasswordReset">Reset Password</Link>
            <Link to="/Register">Create Membership</Link>
          </div>
        </div>
        <div className='theme-toggle'>
          <h2>Change Theme</h2>
          <input type={'checkbox'} onClick={switchTheme} />

        </div>
      </div>
    </div>
  );
}

export default Login;
