import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
class LiveSearch extends React.Component{
    constructor(props){
        super(props);
        this.state = {name: this.props.name, query: this.props.query, message: this.props.message, result: ""}
        this.handleChange= this.handleChange.bind(this)
        this.fetchResult= this.fetchResult.bind(this)
    }
    handleChange=(event)=>{
        const query= event.target.value
        console.log(query)
        this.setState(state => ({query: query}))
        this.fetchResult(query)
    }
    fetchResult=(query)=>{
        const axios = require('axios');
        const url=`https://sandbox.iexapis.com/stable/stock/${query}/quote?token=Tsk_344e895a27c741bcbc4da9175df09166`
        axios.get(url)
        .then(function(response){
            console.log(response.data.companyName)
        })
        .catch(function(error){
           
            
            console.log("Invalid ticker symbol")
        })


    }
    render() {
        return (
        <React.Fragment>
            
            <input type="text" 
                    name={this.name}
                    value={this.query}
                    onChange={this.handleChange}>
                    </input>

        </React.Fragment>);
    }
    
}
LiveSearch.propTypes={
                name: PropTypes.string,
                message: PropTypes.string
}
export default  LiveSearch