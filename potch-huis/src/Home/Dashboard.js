import React, { useState, useEffect } from "react";
import Topbar from "../Layout/Topbar";

const Dashboard = () => {
  const [data, setData] = useState({});

  useEffect(() => {
    // Make API call to fetch data and update state
    fetch("/api/data")
      .then((response) => response.json())
      .then((data) => setData(data))
      .catch((error) => console.log(error));
  }, []);

  return (
    <React.Fragment>
      <Topbar />
      <div className="dashboard">
        <h1>Dashboard</h1>
        <div className="metrics">
          <div className="metric">
            <div className="metric-value">{data.users}</div>
            <div className="metric-label">Users</div>
          </div>
          <div className="metric">
            <div className="metric-value">{data.sales}</div>
            <div className="metric-label">Sales</div>
          </div>
          <div className="metric">
            <div className="metric-value">{data.visitors}</div>
            <div className="metric-label">Visitors</div>
          </div>
        </div>
      </div>
    </React.Fragment>
  );
};

export default Dashboard;
