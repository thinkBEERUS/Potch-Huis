import Navbar from './Navbar.js';
import Footer from './Footer.js';
import './Layout.css';

function Layout({bodyElements}) {
    return (
        <div className='layout'>
            <Navbar />
            <main>{bodyElements}</main>
            <Footer />
        </div>
    );
}

export default Layout;
