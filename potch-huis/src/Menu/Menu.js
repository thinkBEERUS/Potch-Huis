import '../index.css';
import Layout from '../Layout/Layout.js';
import { Link } from 'react-router-dom';
import Select from 'react-select';
import Carousel from 'react-bootstrap/Carousel';
import Card from 'react-bootstrap/Card';

function Menu() {
  const aquaticCreatures = [
    { label: 'Shark', value: 'Shark' },
    { label: 'Dolphin', value: 'Dolphin' },
    { label: 'Whale', value: 'Whale' },
    { label: 'Octopus', value: 'Octopus' },
    { label: 'Crab', value: 'Crab' },
    { label: 'Lobster', value: 'Lobster' },
  ];
  return (
    <Layout bodyElements={
    <div className='body'>
      <div className='card'>        
        <div className='container'>
          <div>
            <Select
              options={aquaticCreatures}
              isMulti
              placeholder={'Add Items'}
              className='btn pBtn'
              />
            <Select
              options={aquaticCreatures}
              isMulti
              placeholder={'Remove Items'}
              className='btn pBtn'
            />
          </div>
          <div className='sliderMenu'>
            <Carousel variant="dark">
              <Carousel.Item>
                <hr />
                <h1 className='sliderMenuItem'>Gorilla Glue</h1>
                <hr />
                <Carousel.Caption>
                  <hr />
                  <h5>First slide label</h5>
                  <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                </Carousel.Caption>
              </Carousel.Item>
              <Carousel.Item>
                <hr />
                <h1 className='sliderMenuItem'>Delux Sugarcane</h1>
                <hr />
                <Carousel.Caption>
                  <hr />
                  <h5>Second slide label</h5>
                  <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                </Carousel.Caption>
              </Carousel.Item>
              <Carousel.Item>
                <hr />
                <h1 className='sliderMenuItem'>Super F1 Cheese</h1>
                <hr />
                <Carousel.Caption>
                  <hr />
                  <h5>Third slide label</h5>
                  <p>
                    Praesent commodo cursus magna, vel scelerisque nisl consectetur.
                  </p>
                </Carousel.Caption>
              </Carousel.Item>
            </Carousel>
          </div>
          <div className='cardBox'>
            <div className='flexItem'>
              <Card
                bg={'dark'}
                key={'variant'}
                text={'white'}
                style={{ width: '18rem', height: '25vh' }}
                className="mb-2 cardMargin"
                >
                <Card.Header>Item Name</Card.Header>
                <Card.Body>
                  <Card.Title>Item Image</Card.Title>
                  <Card.Text>
                    Description
                  </Card.Text>
                </Card.Body>
                <Card.Footer>
                  <button className='btn btn-success fBtn'>Details</button>
                  <button className='btn btn-success fBtn'>Add to Cart</button>
                </Card.Footer>
              </Card>
            </div>
            <div className='flexItem'>
              <Card
                bg={'dark'}
                key={'variant'}
                text={'white'}
                style={{ width: '18rem', height: '25vh' }}
                className="mb-2 cardMargin"
                >
                <Card.Header>Item Name</Card.Header>
                <Card.Body>
                  <Card.Title>Item Image</Card.Title>
                  <Card.Text>
                    Description
                  </Card.Text>
                </Card.Body>
                <Card.Footer>
                  <button className='btn btn-success fBtn'>Details</button>
                  <button className='btn btn-success fBtn'>Add to Cart</button>
                </Card.Footer>
              </Card>
            </div>
            <div className='flexItem'>
              <Card
                bg={'dark'}
                key={'variant'}
                text={'white'}
                style={{ width: '18rem', height: '25vh' }}
                className="mb-2 cardMargin"
                >
                <Card.Header>Item Name</Card.Header>
                <Card.Body>
                  <Card.Title>Item Image</Card.Title>
                  <Card.Text>
                    Description
                  </Card.Text>
                </Card.Body>
                <Card.Footer>
                  <button className='btn btn-success fBtn'>Details</button>
                  <button className='btn btn-success fBtn'>Add to Cart</button>
                </Card.Footer>
              </Card>
            </div>
          </div>
        </div>
      </div>
    </div>
    }>
    </Layout>
  );
}

export default Menu;
