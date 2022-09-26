import './Navbar.css';
import logo from '../Assets/potch-huis-logo.jpg';

function Navbar() {
  return (
  <>
    <div class="navbar" style={{height: "10vh"}}>
      <img src={logo} alt="Logo" className='logo' />
      <a href="~/Dashboard">Home</a>
      <a href="#news">News</a>
      <a href="#contact">Contact</a>
    </div>
  </>
  );
}

export default Navbar;
