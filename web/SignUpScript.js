function validateForm() 
{
    var user = document.forms["signup"]["user"].value;
    var pass = document.forms["signup"]["pass"].value;
    var pass2 = document.forms["signup"]["pass2"].value;
    var fname = document.forms["signup"]["fname"].value;
    var lname = document.forms["signup"]["lname"].value;
    var email = document.forms["signup"]["email"].value;
    var phone = document.forms["signup"]["phone"].value;

    //Email Pattern
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    
    //Phone Pattern
    var re2 = /^\d{8,11}$/;
    
    if(user == "" || pass == "" || pass2 == "" || fname == "" || lname == "" || email == ""|| phone == "")
    {
        alert("Please fill out all the fields");
        return false;
    }

    else if(pass != pass2)
    {
        alert("Passwords don't match");
        return false;
    }

    else if(!re.test(String(email).toLowerCase()))
    {
        alert("Invalid email");
        return false;
    }
    
    else if(!re2.test(phone))
    {
        alert("Invalid Phone Number");
        return false;
    }
}


