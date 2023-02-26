import "../index.css";
import { Link } from "react-router-dom";
import useLocalStorage from "use-local-storage";
import React, { useState } from "react";
import { FileUploader } from "react-drag-drop-files";
import pdf from "../Assets/MembershipFiles/PH-Membership-Files.zip";
const fileTypes = ["PDF"];

//https://drive.google.com/uc?id=1lxG7t6WcOD0SDV7X_-dG_Dna4C41h1oK&export=download NDA
//https://drive.google.com/uc?id=1paCyDuoko6tx0n7GdPGtEn6etHfl_fUh&export=download Membership Form
//https://drive.google.com/uc?id=1Y3EbEMynlTVl6FhMGCCiWPdPIdbsqzn0&export=download Waiver & Indemnity
//https://drive.google.com/uc?id=19Ry4edlY2M6q9VbFTBMudVHmUU1hed-Y&export=download Club Constitution
function DocumentList() {
  const [file, setFile] = useState(null);
  const handleChange = (file) => {
    setFile(file);
  };
  const [theme, setTheme] = useLocalStorage("theme" ? "dark" : "light");

  const switchTheme = () => {
    const newTheme = theme === "light" ? "dark" : "light";
    setTheme(newTheme);
  };

  function downloadPdfFiles() {
    const link = document.createElement("a");
    link.href = pdf;
    link.download = "PH-Membership-Files.zip";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }

  return (
    <div className="app" data-theme={theme}>
      <div className="login-container">
        <h1>Membership Files</h1>
        <div className="container">
          <div className="top"></div>
          <p className="divider">
            <span>Good Times & Lekker People</span>
          </p>
          <form>
            <label>Please download and complete the following documents:</label>
            <div className="login-container">
              <ol>
                <li>Confidentiality & NDA</li>
                <li>Membership Form</li>
                <li>Standard Waiver & Indemnity Agreement</li>
                <li>Social Club Constitution</li>
              </ol>
            </div>
            <button className="btn btn-primary" onClick={downloadPdfFiles}>
              Membership Files
            </button>
            <div className="upload-area">
              <FileUploader
                handleChange={handleChange}
                name="file"
                types={fileTypes}
              />
            </div>
            <Link to="/" className="btn btn-success">
              Save
            </Link>
          </form>
        </div>
      </div>
    </div>
  );
}

export default DocumentList;
