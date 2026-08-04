let expression = "";

const display = document.getElementById("display");

function updateDisplay(){

    display.innerText = expression || "0";
}

function appendValue(value){

    expression += value;

    updateDisplay();
}

function clearDisplay(){

    expression="";

    updateDisplay();
}

function deleteLast(){

    expression=expression.slice(0,-1);

    updateDisplay();
}

async function calculate(){

    if(expression==="") return;

    try{

        const response=await fetch("/calculate",{

            method:"POST",

            headers:{
                "Content-Type":"application/json"
            },

            body:JSON.stringify(parseExpression(expression))

        });

        const data=await response.json();

        if(data.result!==undefined){

            expression = parseFloat(data.result.toFixed(4)).toString();
        }
        else{

            expression="Error";
        }

        updateDisplay();

    }catch(e){

        expression="Error";

        updateDisplay();
    }
}

function parseExpression(exp){

    const operators=["+","-","*","/"];

    for(const op of operators){

        const index=exp.indexOf(op);

        if(index>0){

            return{

                num1:parseFloat(exp.substring(0,index)),

                num2:parseFloat(exp.substring(index+1)),

                operation:getOperation(op)
            };
        }
    }

    return{};
}

function getOperation(op){

    switch(op){

        case "+": return "add";

        case "-": return "subtract";

        case "*": return "multiply";

        case "/": return "divide";
    }
}

document.addEventListener("keydown",(e)=>{

    if("0123456789.+-*/".includes(e.key)){

        appendValue(e.key);
    }

    if(e.key==="Enter"){

        calculate();
    }

    if(e.key==="Backspace"){

        deleteLast();
    }

    if(e.key==="Escape"){

        clearDisplay();
    }
});