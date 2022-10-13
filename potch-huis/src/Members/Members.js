import { Link } from 'react-router-dom';
import Layout from '../Layout/Layout.js';
import '../index.css';

import React, { useState } from 'react';
import Button from 'react-bootstrap/Button';
import Col from 'react-bootstrap/Col';
import Row from 'react-bootstrap/Row';
import Toast from 'react-bootstrap/Toast';

function Members() {
    const [show, setShow] = useState(false);

  return (
    <Layout bodyElements={    
        <React.Fragment>
            <div className='toaster'>
                <Toast bg='dark' onClose={() => setShow(false)} show={show} delay={3000} autohide>
                    <Toast.Header>
                    <strong className="me-auto">Potch Huis</strong>
                    <small>4s ago</small>
                    </Toast.Header>
                    <Toast.Body className='text-white'>Member Saved!</Toast.Body>
                </Toast>
            </div>
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
                                <button className="btn btn-success pBtn" onClick={() => setShow(true)} >Save</button>
                                <Link to="/Dashboard" className="btn btn-danger pBtn">Cancel</Link>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </React.Fragment>
    }>
    </Layout>
  );
}

export default Members;
