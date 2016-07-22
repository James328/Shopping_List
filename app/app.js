//Define an angular module for our app
var app = angular.module('shopApp', []);

app.controller('shopController', function($scope, $http) {
	
  getItem();      // Load all available items
  getList();      // Load all shopping lists
  getSumPrice();  // Sum all of the prices
 
  function getItem(){  
  $http.post("ajax/getItem.php").success(function(data){
        $scope.items = data;
        getSumPrice();
       });
  };

  function getList(){  
  $http.post("ajax/getList.php").success(function(data){
        $scope.lists = data;
       });
  };

  function getSumPrice(){
  $http.post("ajax/getSumPrice.php").success(function(data){
        $scope.sumPrice = data;
      });
  };
  
  $scope.addItem = function (item, quantity) {
    $http.post("ajax/addItem.php?item="+item+"&quantity="+quantity).success(function(data){
        getItem();
        $scope.itemInput = "";
      });
  };

  $scope.addList = function (list) {
    $http.post("ajax/addList.php?list="+list).success(function(data){
        getList();
        $scope.listInput = "";
      });
  };

  $scope.deleteItem = function (item) {
    if(confirm("Are you sure to delete this item?")){
    $http.post("ajax/deleteItem.php?itemID="+item).success(function(data){
        getItem();
      });
    }
  };

  $scope.deleteList = function (list) {
    if(confirm("Are you sure to delete this item?")){
    $http.post("ajax/deleteList.php?listID="+list).success(function(data){
        getList();
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

  $scope.changeStatus = function(item, status) {
    if(status=='2'){status='0';}else{status='2';}
      $http.post("ajax/updateItem.php?itemID="+item+"&status="+status).success(function(data){
        getItem();
      });
  };

  $scope.changeList = function(list) {
      $http.post("ajax/updateList.php?list="+list).success(function(data){
        getItem();
      });
  };

  $scope.addPrice = function (item, price) {
    $http.post("ajax/addPrice.php?itemID="+item+"&price="+price).success(function(data){
        getItem();
        $scope.itemInput = "";
      });
  };

  $scope.increaseQuantity = function(item) {
      $http.post("ajax/increaseQuantity.php?itemID="+item).success(function(data){
        getItem();
      });
  };

  $scope.decreaseQuantity = function(item) {
      $http.post("ajax/decreaseQuantity.php?itemID="+item).success(function(data){
        getItem();
      });
  };

  $scope.showPriceForm = function(item) {
      $("#form-"+item).css("display","inline-block");
      $(".unit-price-"+item).css("display","none");
      $("#edit-price-btn-"+item).css("display","none");
      $("#close-price-btn-"+item).css("display","inline-block");
  };

   $scope.hidePriceForm = function(item) {
      $("#form-"+item).css("display","none");
      $(".unit-price-"+item).css("display","inline-block");
      $("#edit-price-btn-"+item).css("display","inline-block");
      $("#close-price-btn-"+item).css("display","none");
  };

  $scope.addNotes = function (item, notes) {
    $http.post("ajax/addNotes.php?itemID="+item+"&notes="+notes).success(function(data){
        getItem();
        $scope.notesInput = "";
      });
      $("#notesModal-"+item).modal("hide");
  };

});
