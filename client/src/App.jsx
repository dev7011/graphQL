import { useState } from 'react'
import './App.css'

import ProjectsPage from "./features/projects/components/ProjectsPage.jsx";

function App() {
  return (
    <>
      <section id="center">
        <h1
          style={{ color: 'red', fontSize: '3rem', textAlign: "center" }}
        >
          Vite-react in GraphQL
        </h1>
        <ProjectsPage />
      </section>
    </>
  )
}

export default App
