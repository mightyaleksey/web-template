/* @flow */

// $FlowExpectedError[cannot-resolve-module]
import { createRoot } from 'react-dom/client'
import * as React from 'react'

function App() {
  return (
    <span>Hello</span>
  )
}

const domNode = document.getElementById('root')
const root = createRoot(domNode)
root.render(<App />)
