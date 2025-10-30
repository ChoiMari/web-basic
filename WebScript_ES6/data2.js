const message = () => {
    const name = 'hong';
    const age = 40;
    return name + " is " + age + " years old";
};

export default message; //1개만 export할 땐 default키워드 사용
//import할 때 {}안씀