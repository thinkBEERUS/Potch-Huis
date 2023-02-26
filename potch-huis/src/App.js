import Dashboard from "./Home/Dashboard";
import Reports from "./Reports/Reports";
import Members from "./Members/Members";
import Menu from "./Menu/Menu";
import DocumentList from "./Auth/Document";
import { Routes, Route } from "react-router-dom";
import { CssBaseline, ThemeProvider } from "@mui/material";
import { ColorModeContext, useMode } from "./theme";

function App() {
  const [theme, colorMode] = useMode();
  //const [isSidebar, setIsSidebar] = useState(true);

  return (
    <ColorModeContext.Provider value={colorMode}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <div className="app">
          {/* <Sidebar isSidebar={isSidebar} /> */}
          <main className="content">
            <Routes>
              <Route path="Dashboard" element={<Dashboard />} />
              <Route path="Reports" element={<Reports />} />
              <Route path="Members" element={<Members />} />
              <Route path="Menu" element={<Menu />} />
              <Route path="DocumentList" element={<DocumentList />} />
            </Routes>
          </main>
        </div>
      </ThemeProvider>
    </ColorModeContext.Provider>
  );
}

export default App;
