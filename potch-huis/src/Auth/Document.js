import '../index.css';
import { Link } from 'react-router-dom';
import useLocalStorage from 'use-local-storage';
import React, { useState } from "react";
import { FileUploader } from "react-drag-drop-files";
import JSZip from "jszip";
const fileTypes = ["JPG", "PNG", "GIF"];

function DocumentList() {
    const [file, setFile] = useState(null);
    const handleChange = (file) => {
        setFile(file);
    };
  const [theme, setTheme] = useLocalStorage('theme' ? 'dark' : 'light')

  const switchTheme = () => {
    const newTheme = theme === 'light' ? 'dark' : 'light';
    setTheme(newTheme);
  }

  const downloadTxtFile = () => {
    const zipPath = "A:/Git Hub/Potch Huis/potch-huis/src/Assets/MembershipFiles/PH-Membership-Files.zip";
    const zipFile = new JSZip();
    zipFile.file(zipPath);
    const zip = new Blob(zipFile, {type: 'application/zip'});

   // anchor link
    const element = document.createElement("a");
    element.href = URL.createObjectURL(zip);
    element.download = "PH-Membership-Files.zip";

    // simulate link click
    document.body.appendChild(element); // Required for this to work in FireFox
    element.click();
  }

  return (
    <div className="app" data-theme={theme}>
      <div className='login-container'>
        <h1>Membership Files</h1>
        <div className='container'>
          <div className='top'>
          </div>
          <p className='divider'><span>Good Times & Lekker People</span></p>
          <form>
            <label>Please download and complete the following documents:</label>
            <div className='login-container'>
                <ol>
                    <li>Confidentiality & NDA</li>
                    <li>Membership Form</li>
                    <li>Standard Waiver & Indemnity Agreement</li>
                    <li>Social Club Constitution</li>                    
                </ol>                
            </div>
            <button className="btn btn-primary" onClick={downloadTxtFile} value="download">Membership Files</button>
            <div className='upload-area'>
                <FileUploader handleChange={handleChange} name="file" types={fileTypes} />
            </div>            
            <Link to="/" className="btn btn-success">Save</Link>
          </form>
        </div>
      </div>
    </div>
  );
}

export default DocumentList;