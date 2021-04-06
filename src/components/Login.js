import React from 'react'
import Form from './Form'

const Login = props => {

  const testSubmit = (formState) => {
    console.log(formState)
  }

  const initialState = {
    Email: {className: "green", labelClassName: "green"},
    Sick_Colors_Bro: {value: '#aaaaaa', type: "color"},
    Test_Password: {type: "password"}
  }

  const initialState2 = {
    Email: {}
  }

  return(
    <div>
      <Form initialState={initialState} handleSubmit={testSubmit} preventDefault={true} clearOnSubmit={true} submitButtonValue={"Edited Submit Value!"} formClassName="margin"/>
    </div>
  )
}

export default Login