import './Reports.css';
import Layout from '../Layout/Layout.js';
import Table from 'react-bootstrap/Table';

function DarkExample() {
  return (
    <Table striped bordered hover variant="dark">
      <thead>
        <tr>
          <th>#</th>
          <th>Member Number</th>
          <th>Member Name</th>
          <th>Form of Donation</th>
          <th>Request</th>
          <th>Donation Value</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>001MO</td>
          <td>Mark</td>
          <td>Cash</td>
          <td>4 Joints Outdoor</td>
          <td>100</td>
        </tr>    
        <tr>
          <td>2</td>
          <td>002PF</td>
          <td>Penelope</td>
          <td>EFT</td>
          <td>2 Joints Gorilla Glue</td>
          <td>100</td>
        </tr>  
        <tr>
          <td>3</td>
          <td>003SY</td>
          <td>Smithy</td>
          <td>EFT</td>
          <td>2g Sugarcane</td>
          <td>100</td>
        </tr>  
        <tr>
          <td>4</td>
          <td>004JJ</td>
          <td>Jacob</td>
          <td>EFT</td>
          <td>40g Outdoor</td>
          <td>800</td>
        </tr>       
        <tr>
          <td>5</td>
          <td>005KL</td>
          <td>Karel</td>
          <td>Cash</td>
          <td>4 Joints Outdoor</td>
          <td>100</td>
        </tr>   
        <tr>
          <td>1</td>
          <td>001MO</td>
          <td>Mark</td>
          <td>Cash</td>
          <td>4 Joints Outdoor</td>
          <td>100</td>
        </tr>    
        <tr>
          <td>2</td>
          <td>002PF</td>
          <td>Penelope</td>
          <td>EFT</td>
          <td>2 Joints Gorilla Glue</td>
          <td>100</td>
        </tr>  
        <tr>
          <td>3</td>
          <td>003SY</td>
          <td>Smithy</td>
          <td>EFT</td>
          <td>2g Sugarcane</td>
          <td>100</td>
        </tr>  
        <tr>
          <td>4</td>
          <td>004JJ</td>
          <td>Jacob</td>
          <td>EFT</td>
          <td>40g Outdoor</td>
          <td>800</td>
        </tr>       
        <tr>
          <td>5</td>
          <td>005KL</td>
          <td>Karel</td>
          <td>Cash</td>
          <td>4 Joints Outdoor</td>
          <td>100</td>
        </tr>             
      </tbody>
    </Table>
  );
}

function Reports() {
  return (
    <Layout bodyElements={
      <div className='body'>
      <div className='card'>        
        <div className='container'>
            <h1>Reports</h1>
            <DarkExample />
        </div>
      </div>
    </div>
    }>
    </Layout>
  );
}

export default Reports;
