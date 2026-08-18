import { useState } from 'react'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <section id="center">
        <h1
          style={{ color: 'red', fontSize: '3rem', textAlign: "center" }}
        >
          WELCOME </h1>
        <h2>
          vite-react in GraphQL
        </h2>

      </section>

      <div className="ticks"></div>
      <section id="spacer"></section>
    </>
  )
}

export default App
