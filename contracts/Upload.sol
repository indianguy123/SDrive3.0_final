// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Upload {
  //this datatype is used to give access to other users for accessing someones data
  struct Access{
     address user; 
     bool access; //true or false(has access or not)
  }
  //this mapping stores the address of user and an array of urls of image uploaded by user.
  mapping(address=>string[]) value;
  //this is nested mapping like 2D array, has the same application like accesslist Eg:ownership[address1][address2]=true/flase;=>address1 has given access to address2 
  mapping(address=>mapping(address=>bool)) ownership;
  //this mapping shows that who have the access to an account, it is an array because many people can have access to one account
  mapping(address=>Access[]) accessList;
  //to store our previous info on blockchain only, as we are not using NODEJS for our server where we can store data.This is used when someone is entering for first time that it has its access as true,when we disallow it then access becomes false, now if again want to give the permission then we dont want to reinsert this address so we are maintaing previousdata list.
  mapping(address=>mapping(address=>bool)) previousData;
  
  //to store the image in particular account
  function add(address _user,string memory url) external {
      value[_user].push(url);
      
  }
  //to give the access
  function allow(address user) external {//def
      ownership[msg.sender][user]=true; 
      //this previous data is used to check that if we are changing the access of already existing account or not.
      //if one user is first allowed and then disallowed from access list,then again allowing it for access, so we don't want to rewrite it's address, we just want to chage it's access thats what we are doing here.
      if(previousData[msg.sender][user]){
         for(uint i=0;i<accessList[msg.sender].length;i++){
             if(accessList[msg.sender][i].user==user){
                  accessList[msg.sender][i].access=true; 
             }
         }
      }
      else{
          accessList[msg.sender].push(Access(user,true));  
          previousData[msg.sender][user]=true;  
      }
    
  }
  //to remove from access
  function disallow(address user) public{
      ownership[msg.sender][user]=false;
      //to remove the access of specified user
      for(uint i=0;i<accessList[msg.sender].length;i++){
          if(accessList[msg.sender][i].user==user){ 
              accessList[msg.sender][i].access=false; 
              //note:we are can't remove the user as it is blockchain,we can only set its access as false. 
          }
      }
  }

    //to display all the images
  function display(address _user) external view returns(string[] memory){
      require(_user==msg.sender || ownership[_user][msg.sender],"You don't have access");
      return value[_user];
  }
    //to fetch the list of users who have access to our account
  function shareAccess() public view returns(Access[] memory){
      return accessList[msg.sender];
  }
}


//0x5FbDB2315678afecb367f032d93F642f64180aa3