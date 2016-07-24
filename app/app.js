//Define an angular module for our app
var app = angular.module('shopApp', []);

app.controller('shopController', function($scope, $http) {
	
  getItem();        // Load all available items
  getList();        // Load all shopping lists
  getCurrentList(); // Get active_list from user table
  getSumPrice();    // Sum all of the prices
 
  // Item functions
  function getItem(){  
    $http.post("ajax/getItem.php").success(function(data){
      $scope.items = data;
      getSumPrice();
    });
  };
  $scope.addItem = function (name, quantity) {
    $http.post("ajax/addItem.php?name="+name+"&quantity="+quantity).success(function(data){
      getItem();
      $scope.itemInput = "";
    });
  };
  $scope.deleteItem = function (item_id) {
    if(confirm("Are you sure to delete this item?")){
      $http.post("ajax/deleteItem.php?itemID="+item_id).success(function(data){
        getItem();
      });
    }
  };
  $scope.clearItem = function () {
    if(confirm("Delete all checked items?")){
      $http.post("ajax/clearItem.php").success(function(data){
        getItem();
      });
    }
  };
  $scope.changeStatus = function(item_id, status) {
    if(status=='2'){status='0';}else{status='2';}
    $http.post("ajax/updateItem.php?itemID="+item_id+"&status="+status).success(function(data){
      getItem();
    });
  };

  // List functions
  function getList(){  
    $http.post("ajax/getList.php").success(function(data){
      $scope.lists = data;
    });
  };
  function getCurrentList(){
    $http.post("ajax/getCurrentList.php").success(function(data){
      $scope.currentList = data;
    });
  };
  $scope.addList = function (list_name) {
    $http.post("ajax/addList.php?listName="+list_name).success(function(data){
      getList();
      $scope.listInput = "";
    });
  };
  $scope.deleteList = function (list_id) {
    if(confirm("Are you sure to delete this item?")){
      $http.post("ajax/deleteList.php?listID="+list_id).success(function(data){
        getList();
      });
    }
  };
  $scope.changeList = function(list_id) {
    $http.post("ajax/updateList.php?listID="+list_id).success(function(data){
      getItem();
      getCurrentList();
    });
  };

  // Price functions
  function getSumPrice(){
    $http.post("ajax/getSumPrice.php").success(function(data){
      $scope.sumPrice = data;
    });
  };
  $scope.addPrice = function (item_id, price) {
    $http.post("ajax/addPrice.php?itemID="+item_id+"&price="+price).success(function(data){
      getItem();
      $scope.itemInput = "";
    });
  };
  $scope.increaseQuantity = function(item_id) {
    $http.post("ajax/increaseQuantity.php?itemID="+item_id).success(function(data){
      getItem();
    });
  };
  $scope.decreaseQuantity = function(item_id) {
    $http.post("ajax/decreaseQuantity.php?itemID="+item_id).success(function(data){
      getItem();
    });
  };
  $scope.showPriceForm = function(item_id) {
    $("#form-"+item_id).css("display","inline-block");
    $(".unit-price-"+item_id).css("display","none");
    $("#edit-price-btn-"+item_id).css("display","none");
    $("#close-price-btn-"+item_id).css("display","inline-block");
  };
  $scope.hidePriceForm = function(item_id) {
    $("#form-"+item_id).css("display","none");
    $(".unit-price-"+item_id).css("display","inline-block");
    $("#edit-price-btn-"+item_id).css("display","inline-block");
    $("#close-price-btn-"+item_id).css("display","none");
  };

  // Notes functions
  $scope.addNotes = function (item, notes) {
    $http.post("ajax/addNotes.php?itemID="+item+"&notes="+notes).success(function(data){
      getItem();
      $scope.notesInput = "";
    });
    $("#notesModal-"+item).modal("hide");
  };

});
