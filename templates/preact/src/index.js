/* @flow */

// $FlowExpectedError[cannot-resolve-module]
import { createRoot } from 'react-dom/client'
import * as React from 'react'

const domNode = document.getElementById('root')
const root = createRoot(domNode)
root.render(<App />)

function App() {
  return (
    <span>Hello</span>
  )
}