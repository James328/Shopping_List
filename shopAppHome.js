// templates/home.html angular module
angular.module( 'shopApp.home', [
'auth0'
])
.controller('shopController', function shopController($scope, auth, $http, $location, store, $rootScope) {

  // Auth0 functions
  $scope.auth = auth;
  //console.log($rootScope.profile);
  var auth_id = $scope.auth.profile.user_id;
  console.log("Auth_id: "+auth_id);
  $scope.callApi = function() {
    // Just call the API as you'd do using $http
    $http({
      url: 'http://localhost:3001/secured/ping',
      method: 'GET'
    }).then(function() {
      alert("We got the secured data successfully");
    }, function(response) {
      if (response.status == -1) {
        alert("Please download the API seed so that you can call it.");
      }
      else {
        alert(response.data);
      }
    });
  };
  $scope.logout = function() {
    auth.signout();
    store.remove('profile');
    store.remove('token');
    $location.path('/login');
  }

  // Initialize the app
  getItem();        // Load all available items
  getList();        // Load all shopping lists
  getCurrentList(); // Get active_list from user table
  getSumPrice();    // Sum all of the prices
 
  // Main app ajax functions
  // Item functions
  function getItem(){
    $http.post("ajax/getItem.php?authID="+auth_id).success(function(data){
      $scope.items = data;
      getSumPrice();
    });
  };
  $scope.addItem = function (name, quantity) {
    $http.post("ajax/addItem.php?authID="+auth_id+"&name="+name+"&quantity="+quantity).success(function(data){
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

  //Quantity functions
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

  // Price functions
  function getSumPrice(){
    $http.post("ajax/getSumPrice.php?authID="+auth_id).success(function(data){
      $scope.sumPrice = data;
    });
  };
  $scope.addPrice = function (item_id, price) {
    $http.post("ajax/addPrice.php?itemID="+item_id+"&price="+price).success(function(data){
      getItem();
      $scope.itemInput = "";
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
  $scope.addNotes = function (item_id, notes) {
    $http.post("ajax/addNotes.php?itemID="+item_id+"&notes="+notes).success(function(data){
      getItem();
      $scope.notesInput = "";
    });
    $("#notesModal-"+item_id).modal("hide");
  };

  // List functions
  function getList(){  
    $http.post("ajax/getList.php?authID="+auth_id).success(function(data){
      $scope.lists = data;
    });
  };
  function getCurrentList(){
    $http.post("ajax/getCurrentList.php?authID="+auth_id).success(function(data){
      $scope.currentList = data;
    });
  };
  $scope.addList = function (list_name) {
    $http.post("ajax/addList.php?authID="+auth_id+"&listName="+list_name).success(function(data){
      getList();
      $scope.listInput = "";
    });
  };
  $scope.deleteList = function (list_id) {
    if(confirm("Are you sure to delete this item?")){
      $http.post("ajax/deleteList.php?listID="+list_id+"&authID="+auth_id).success(function(data){
        getList();
        getCurrentList();
        getItem();
      });
    }
  };
  $scope.changeList = function(list_id) {
    $http.post("ajax/updateList.php?authID="+auth_id+"&listID="+list_id).success(function(data){
      getItem();
      getCurrentList();
    });
  };
})
.filter('debug', function() {
  return function(input) {
    if (input === '') return 'empty string';
    return input ? input : ('' + input);
  };
});