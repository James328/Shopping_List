// Primary angular module for app
angular.module('shopApp', [
  'auth0',
  'ngRoute',
  'shopApp.home',
  'angular-storage',
  'angular-jwt'
])
.config( function myAppConfig ( $routeProvider, authProvider, $httpProvider, $locationProvider,
  jwtInterceptorProvider) {

  $routeProvider
    .when( '/', {
      controller: 'shopController',
      templateUrl: 'templates/home.html',
      pageTitle: 'Homepage',
      requiresLogin: true
    })
    .when( '/login', {
      controller: 'LoginCtrl',
      templateUrl: 'templates/login.html',
      pageTitle: 'Login'
    });

  authProvider.init({
    domain: 'jamesh.auth0.com',
    clientID: 'iRUrYsnUKKmbe6CAvl2taQNlDiGsFpaZ',
    loginUrl: '/login'
  });

  authProvider.on('loginSuccess', function($location, profilePromise, idToken, store) {
    console.log("Login Success");
    profilePromise.then(function(profile) {
      store.set('profile', profile);
      store.set('token', idToken);
    });
    $location.path('/');
  });

  authProvider.on('loginFailure', function() {
    alert("Error");
  });

  authProvider.on('authenticated', function($location) {
    console.log("Authenticated");
  });

  jwtInterceptorProvider.tokenGetter = function(store) {
    return store.get('token');
  };

  // Add a simple interceptor that will fetch all requests and add the jwt token to its authorization header.
  // NOTE: in case you are calling APIs which expect a token signed with a different secret, you might
  // want to check the delegation-token example
  $httpProvider.interceptors.push('jwtInterceptor');
})
.run(function($rootScope, auth, store, jwtHelper, $location) {
  $rootScope.$on('$locationChangeStart', function() {

    var token = store.get('token');
    if (token) {
      if (!jwtHelper.isTokenExpired(token)) {
        if (!auth.isAuthenticated) {
          auth.authenticate(store.get('profile'), token);
        }
      } else {
        // Either show the login page or use the refresh token to get a new idToken
        $location.path('/');
      }
    }

  });
})
// index.html controller
.controller( 'AppCtrl', function AppCtrl ( $scope, $location ) {
  $scope.$on('$routeChangeSuccess', function(e, nextRoute){
    if ( nextRoute.$$route && angular.isDefined( nextRoute.$$route.pageTitle ) ) {
      $scope.pageTitle = nextRoute.$$route.pageTitle + ' | Auth0 Sample' ;
    }
  });
})
// templates/login.html controller
.controller( 'LoginCtrl', function ( $scope, auth, $rootScope) {
  $scope.auth = auth;
});

// tmeplates/home.html angular module
angular.module( 'shopApp.home', [
'auth0'
])
.controller('shopController', function shopController($scope, auth, $http, $location, store, $rootScope) {

  // Auth0 functions
  $scope.auth = auth;
  console.log($rootScope.profile);
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

  var auth_id = auth.profile.user_id;
  console.log(auth_id);

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
        getCurrentList();
        getItem();
      });
    }
  };
  $scope.changeList = function(list_id) {
    $http.post("ajax/updateList.php?listID="+list_id).success(function(data){
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