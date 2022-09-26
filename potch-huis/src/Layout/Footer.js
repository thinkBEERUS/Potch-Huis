import './Footer.css';

function Footer() {
    const date = new Date();
    const currentYear = `${date.getFullYear()}`;
  return (
  <>
    <footer class="site-footer">
        <div className='columns'>
            <article className='column'>
                <h6>About</h6>
                <p class="text-justify"><i>Potch Huis Social Club</i> *a message from Dani*</p>
            </article>
            <hr />
            <article className='column'>        
            <h6>Quick Strains</h6>
                <ul class="footer-links">
                    <li><a href="http://scanfcode.com/category/c-language/">Indoor</a></li>
                    <li><a href="http://scanfcode.com/category/front-end-development/">Indica</a></li>
                    <li><a href="http://scanfcode.com/category/back-end-development/">Greenhouse</a></li>
                    <li><a href="http://scanfcode.com/category/java-programming-language/">Hybrid</a></li>
                    <li><a href="http://scanfcode.com/category/android/">Sativa</a></li>
                    <li><a href="http://scanfcode.com/category/templates/">Outdoor</a></li>
                </ul>
            </article>
            <hr />
            <article className='column'>
                <h6>Quick Links</h6>
                <ul class="footer-links">
                    <li><a href="http://scanfcode.com/about/">About Us</a></li>
                    <li><a href="http://scanfcode.com/contact/">Contact Us</a></li>
                    <li><a href="http://scanfcode.com/contribute-at-scanfcode/">Contribute</a></li>
                    <li><a href="http://scanfcode.com/privacy-policy/">Privacy Policy</a></li>
                </ul>
            </article>
        </div>
    </footer>
    <article class="site-copyright">
        <p class="copyright-text">Copyright &copy; {currentYear} All Rights Reserved by <strong>Potch Huis 420 NPC</strong></p>
    </article>
  </>
  );
}

export default Footer;
