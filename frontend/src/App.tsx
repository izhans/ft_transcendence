
import { useEffect, useState } from 'react'
import './App.css'

function App() {
  const [message, setMessage] = useState('Conectando con el backend...')

  useEffect(() => {
    const controller = new AbortController()

    fetch('/api', {
      method: 'GET',
      signal: controller.signal,
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error(`HTTP ${response.status}`)
        }
        return response.text()
      })
      .then((data) => setMessage(data))
      .catch((error) => {
        if (error.name !== 'AbortError') {
          setMessage('Backend no disponible todavía')
        }
      })

    return () => controller.abort()
  }, [])

  return (
    <main>
      <h1>Trascendence - Cluedo</h1>
      <p>{message}</p>
    </main>
  )
}

export default App
