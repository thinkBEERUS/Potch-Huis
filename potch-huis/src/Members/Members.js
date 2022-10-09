import { Link } from 'react-router-dom';
import Layout from '../Layout/Layout.js';
import './Members.css';

function Members() {
  return (
    <Layout bodyElements={    
        <div class='body'>
            <div class='card'>        
                <div class='container'>
                    <h3>New Member</h3>
                    <br />
                    <form class='container'>
                        <input type='text' name='MemberNumber' placeholder='Member Number' />
                        <input type='text' name='Name' placeholder='Name' />
                        <input type='text' name='Surname' placeholder='Surname' />
                        <input type='email' name='Email' placeholder='Email' />
                        <input type='tel' name='PhoneNumber' placeholder='Phone Number' />
                        <div className='buttons'>
                            <Link to="/Dashboard" className="btn btn-success pBtn">Save</Link>
                            <Link to="/Dashboard" className="btn btn-danger pBtn">Cancel</Link>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    }>
    </Layout>
  );
}

export default Members;
