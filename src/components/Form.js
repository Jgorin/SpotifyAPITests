/*
Used to generate a form given a hash of input data
input data comes in form of:

const initialState = {
  name_of_input_field1: {value: (defaults to ""), type: (default is text), className: (className for input field), labelClassName: (className for label field)},
  name_of_input_field2: ...
}

PROP PARAMETERS:

initialState - entire input data listed above
handleSubmit - function to be called when submited
preventDefault - prevents default behaviour when submitting
clearOnSubmit - determines if form should be cleared after submitting
submitButtonValue - submit button text value
formClassName - the form's class

*/

import React, {useState} from 'react'

const DEFAULT_STATE_HASH = {
  'checkbox': 'false',
  'color': '#ffffff',
  'date': '1900-01-01',
  'datetime-local': '2018-06-12T19:30',
  'email': '',
  'text': '',
  'password': ''
}

const Form = (props) => {

  const getInitialState = () => {
    let state = {}
    for(const [inputName, hash] of Object.entries(initialState)){
      let type = hash.type === undefined ? "text" : hash.type
      state[inputName] = hash.value === undefined ? DEFAULT_STATE_HASH[`${type}`] : hash.value
    }
    return state
  }

  const { initialState, handleSubmit, preventDefault, clearOnSubmit, submitButtonValue, formClassName } = props
  const [formState, setFormState] = useState(getInitialState())

  const handleSubmitWrapper = (event) => {
    if(preventDefault){
      event.preventDefault()
    }

    handleSubmit(formState)

    if(clearOnSubmit){
      setFormState(getInitialState())
    }
  }

  const handleChange = (event) => {
    setFormState({
      ...formState,
      [event.currentTarget.id]: event.currentTarget.value
    })
  }

  const populateForm = () => {
    let id = 0
    let formComponents = []
    for(const [formName, hash] of Object.entries(initialState)){
      let newComponent = 
        <div key={id}>
          <label htmlFor={formName} className={hash.labelClassName}>{formName.replaceAll("_", " ")}</label>
          <input type={hash.type !== undefined ? hash.type : "text"} name={formName} id={formName} value={formState[`${formName}`]} onChange={handleChange} className={hash.className}/>
        </div>
      formComponents = formComponents.concat([newComponent])
      id += 1
    }
    formComponents = formComponents.concat([<input type="submit" key={formComponents.length} value={submitButtonValue}/>])
    return formComponents
  }

  let formComponents = populateForm()

  return(
    <form onSubmit={handleSubmitWrapper} className={formClassName}>
      {formComponents}
    </form>
  )
}

export default Form