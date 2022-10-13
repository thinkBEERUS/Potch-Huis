import React from "react";
import Layout from "../Layout/Layout";
import { Link } from 'react-router-dom';

// Import react-circular-progressbar module and styles
import {
  CircularProgressbar,
  CircularProgressbarWithChildren,
  buildStyles
} from "react-circular-progressbar";
import "react-circular-progressbar/dist/styles.css";
import '../index.css';

// Animation
import { easeQuadInOut } from "d3-ease";
import AnimatedProgressProvider from "../ProgressBar/AnimatedProgressProvider";
import ChangingProgressProvider from "../ProgressBar/ChangingProgressProvider";

// Radial separators
import RadialSeparators from "../ProgressBar//RadialSeparators";
import Accordion from 'react-bootstrap/Accordion';
import Card from 'react-bootstrap/Card';
import ProgressBar from 'react-bootstrap/ProgressBar';

const percentage = 66;

const Dashboard = () => (
  <Layout bodyElements={
    <div style={{ padding: "40px 40px 40px 40px" }}>
      <div style={{display: "flex", flexDirection: "row", float: "left"}}>
        <div className='dashButtons'>
          <Link to="/Reports" className="btn btn-success dashBtn">Reports</Link>
          <Link to="/Members" className="btn btn-success dashBtn">Members</Link>
          <Link to="/Stock" className="btn btn-success dashBtn">Stock</Link>
          <Link to="/Donations" className="btn btn-success dashBtn">Donations</Link>
          <Link to="/Menu" className="btn btn-success dashBtn">Menu</Link>
        </div>
      </div>
      <div style={{display: "flex", flexDirection: "row", justifyContent: "center", alignItems: "center", marginRight: "5%"}}>
        <Example label="Dashboard/speedometer">
          <ChangingProgressProvider values={[0, 20, 80]}>
            {value => (
              <CircularProgressbar
                value={value}
                text={`${value}%`}
                circleRatio={0.75}
                styles={buildStyles({
                  rotation: 1 / 2 + 1 / 8,
                  strokeLinecap: "butt",
                  trailColor: "#eee"
                })}
              />
            )}
          </ChangingProgressProvider>
        </Example>
        <div style={{display: "flex", flexDirection: "column", justifyContent: "space-evenly", width: "50%", marginLeft: "5%"}}>
          <div>
            Cleaned Bud, 75g
            <ProgressBar animated now={75} style={{margin: "4%"}} />
          </div>
          <div>
            Buffer: 30g
            <ProgressBar animated now={30} style={{margin: "4%"}} />
          </div>
          <div>
            Uncleaned Bud, 100g
            <ProgressBar animated now={100} style={{margin: "4%"}} />
          </div>
          <div>
            Sold for the month: 200g
            <ProgressBar animated now={200} style={{margin: "4%"}} />  
          </div>
      
        </div>     
      </div>
      <Accordion flush>
        <Accordion.Item eventKey="0">
          <Accordion.Header>Outdoor</Accordion.Header>
          <Accordion.Body>
            <div style={{display: "flex", flexDirection: "row", justifyContent: "center", alignItems: "center"}}>
              <Example label="Default" style={{marginLeft: "20vh"}} >
                  <CircularProgressbar value={percentage} text={`${percentage}%`} />
              </Example>
              <StockDescription />            
            </div>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="1">
          <Accordion.Header>Sativa</Accordion.Header>
          <Accordion.Body>
            <Example label="Stroke width">
              <CircularProgressbar
                value={percentage}
                text={`${percentage}%`}
                strokeWidth={5}
              />
            </Example>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="2">
          <Accordion.Header>Gorilla Glue</Accordion.Header>
          <Accordion.Body>
            <Example label="Square linecaps">
              <CircularProgressbar
                value={percentage}
                text={`${percentage}%`}
                styles={buildStyles({
                  strokeLinecap: "butt"
                })}
              />
            </Example>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="3">
          <Accordion.Header>Delux Sugarcane</Accordion.Header>
          <Accordion.Body>
            <Example label="Custom colors">
              <CircularProgressbar
                value={percentage}
                text={`${percentage}%`}
                styles={buildStyles({
                  textColor: "red",
                  pathColor: "turquoise",
                  trailColor: "gold"
                })}
              />
            </Example>
          </Accordion.Body>
        </Accordion.Item>  
        <Accordion.Item eventKey="4">
          <Accordion.Header>Wonderpie</Accordion.Header>
          <Accordion.Body>
            <Example label="Text size">
              <CircularProgressbar
                value={percentage}
                text={`${percentage}%`}
                styles={buildStyles({
                  // This is in units relative to the 100x100px
                  // SVG viewbox.
                  textSize: "14px"
                })}
              />
            </Example>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="5">
          <Accordion.Header>Franco's Lemon Cheese</Accordion.Header>
          <Accordion.Body>
            <Example label="Rotation">
              <CircularProgressbar
                value={percentage}
                text={`${percentage}%`}
                styles={buildStyles({
                  rotation: 0.5 + (1 - percentage / 100) / 2
                })}
              />
            </Example>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="6">
          <Accordion.Header>Exodus Cheese</Accordion.Header>
          <Accordion.Body>
            <Example label="Default animation speed">
              <ChangingProgressProvider values={[0, 20, 40, 60, 80, 100]}>
                {percentage => (
                  <CircularProgressbar value={percentage} text={`${percentage}%`} />
                )}
              </ChangingProgressProvider>
            </Example>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="7">
          <Accordion.Header>Super F1 Cheese</Accordion.Header>
          <Accordion.Body>
            <Example label="Custom animation speed">
              <ChangingProgressProvider values={[0, 20, 40, 60, 80, 100]}>
                {percentage => (
                  <CircularProgressbar
                    value={percentage}
                    text={`${percentage}%`}
                    styles={buildStyles({
                      pathTransitionDuration: 0.15
                    })}
                  />
                )}
              </ChangingProgressProvider>
            </Example>
          </Accordion.Body>
        </Accordion.Item>  
        <Accordion.Item eventKey="8">
          <Accordion.Header>Outdoor</Accordion.Header>
          <Accordion.Body>
            <Example label="No animation when returning to 0">
              <ChangingProgressProvider values={[0, 100]}>
                {percentage => (
                  <CircularProgressbar
                    value={percentage}
                    text={`${percentage}%`}
                    styles={buildStyles({
                      pathTransition:
                        percentage === 0 ? "none" : "stroke-dashoffset 0.5s ease 0s"
                    })}
                  />
                )}
              </ChangingProgressProvider>
            </Example>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="9">
          <Accordion.Header>Sativa</Accordion.Header>
          <Accordion.Body>
            <Example label="Fully controlled text animation using react-move">
              <AnimatedProgressProvider
                valueStart={0}
                valueEnd={66}
                duration={1.4}
                easingFunction={easeQuadInOut}
                repeat
              >
                {value => {
                  const roundedValue = Math.round(value);
                  return (
                    <CircularProgressbar
                      value={value}
                      text={`${roundedValue}%`}
                      /* This is important to include, because if you're fully managing the
                animation yourself, you'll want to disable the CSS animation. */
                      styles={buildStyles({ pathTransition: "none" })}
                    />
                  );
                }}
              </AnimatedProgressProvider>
            </Example>
          </Accordion.Body>
        </Accordion.Item>
        <Accordion.Item eventKey="10">
          <Accordion.Header>Outdoor</Accordion.Header>
          <Accordion.Body>
            <Example label="Arbitrary content">
              <CircularProgressbarWithChildren value={66}>
                {/* Put any JSX content in here that you'd like. It'll be vertically and horizonally centered. */}
                <img
                  style={{ width: 40, marginTop: -5 }}
                  src="https://i.imgur.com/b9NyUGm.png"
                  alt="doge"
                />
                <div style={{ fontSize: 12, marginTop: -5 }}>
                  <strong>66%</strong> mate
                </div>
              </CircularProgressbarWithChildren>
            </Example>
            <Example label="Multiple overlapping paths">
              <CircularProgressbarWithChildren
                value={80}
                styles={buildStyles({
                  pathColor: "#f00",
                  trailColor: "#eee",
                  strokeLinecap: "butt"
                })}
              >
                {/* Foreground path */}
                <CircularProgressbar
                  value={70}
                  styles={buildStyles({
                    trailColor: "transparent",
                    strokeLinecap: "butt"
                  })}
                />
              </CircularProgressbarWithChildren>
            </Example>
            <Example label="Multiple concentric paths">
              <CircularProgressbarWithChildren
                value={75}
                strokeWidth={8}
                styles={buildStyles({
                  pathColor: "#f00",
                  trailColor: "transparent"
                })}
              >
                {/*
                  Width here needs to be (100 - 2 * strokeWidth)% 
                  in order to fit exactly inside the outer progressbar.
                */}
                <div style={{ width: "84%" }}>
                  <CircularProgressbar
                    value={70}
                    styles={buildStyles({
                      trailColor: "transparent"
                    })}
                  />
                </div>
              </CircularProgressbarWithChildren>
            </Example>
            <Example label="Background">
              <CircularProgressbar
                value={percentage}
                text={`${percentage}%`}
                background
                backgroundPadding={6}
                styles={buildStyles({
                  backgroundColor: "#3e98c7",
                  textColor: "#fff",
                  pathColor: "#fff",
                  trailColor: "transparent"
                })}
              />
            </Example>
            <Example label="Counterclockwise">
              <CircularProgressbar
                value={percentage}
                text={`${percentage}%`}
                counterClockwise
              />
            </Example>

            <Example label="Pie chart">
              <CircularProgressbar
                value={percentage}
                strokeWidth={50}
                styles={buildStyles({
                  strokeLinecap: "butt"
                })}
              />
            </Example>
            <Example label="Progressbar with separators">
              <CircularProgressbarWithChildren
                value={80}
                text={`${80}%`}
                strokeWidth={10}
                styles={buildStyles({
                  strokeLinecap: "butt"
                })}
              >
                <RadialSeparators
                  count={12}
                  style={{
                    background: "#fff",
                    width: "2px",
                    // This needs to be equal to props.strokeWidth
                    height: `${10}%`
                  }}
                />
              </CircularProgressbarWithChildren>
            </Example>
            <Example label="Dashboard/speedometer">
              <ChangingProgressProvider values={[0, 20, 80]}>
                {value => (
                  <CircularProgressbar
                    value={value}
                    text={`${value}%`}
                    circleRatio={0.75}
                    styles={buildStyles({
                      rotation: 1 / 2 + 1 / 8,
                      strokeLinecap: "butt",
                      trailColor: "#eee"
                    })}
                  />
                )}
              </ChangingProgressProvider>
            </Example>
          </Accordion.Body>
        </Accordion.Item>         
      </Accordion>
    </div>
  }>
  </Layout>
);

function Example(props) {
  return (
    <div style={{ display: "flex", flexDirection: "column", marginLeft: "10%", alignItems: "center" }}>
      <h4 style={{margin: "5%"}}>Current Stock</h4>
      <div>{props.children}</div>
      <h6 style={{margin: "5%"}}>200g available out of 300g</h6>
    </div>
  );
}


function StockDescription() {
  return (
    <Card style={{ marginLeft: "60vh"}} >
      <Card.Body>
        <Card.Text>
          Cleaned Bud, 75g
          <ProgressBar animated now={75} style={{margin: "4%"}} />
          Uncleaned Bud, 100g
          <ProgressBar animated now={100} style={{margin: "4%"}} />
          Buffer: 30g
          <ProgressBar animated now={30} style={{margin: "4%"}} />
          Sold for the month: 200g
          <ProgressBar animated now={200} style={{margin: "4%"}} />
        </Card.Text>
      </Card.Body>
      <Card.Footer>
        <a href="/Potch-Huis/Dashboard" className="btn btn-success">Update Stock</a>
      </Card.Footer>
    </Card>
  );
}

export default Dashboard;
