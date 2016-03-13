(function(){
  'use strict';

  angular.module('diversifyApp', ['ngMaterial', 'ui.router'])
  // ROUTER
    .config(['$mdThemingProvider', '$stateProvider', '$urlRouterProvider',
      function($mdThemingProvider, $stateProvider, $urlRouterProvider){
        $urlRouterProvider.otherwise('/');
        $stateProvider
        .state('home', {
          url: '/',
          views: {
            'header': {
              templateUrl: '/templates/partials/header.html'
            },
            'content': {
          controller: '',
              templateUrl: '/templates/index.html'
            }
          }
        })
        .state('matches', {
          url: '/matches',
          views: {
            'header': {
              templateUrl: '/templates/partials/header.html'
            },
        'content': {
        templateUrl: '/templates/matches/index.html',
          controller: 'MatchesController'
                      },
        }
          }
        )
        .state('login', {
          url: '/login',
          views: {
            'header': {
              templateUrl: '/templates/partials/header.html'
            },
            'content': {
          controller: 'loginController',
              templateUrl: '/templates/sessions/new.html'
            }
        }
        })
        .state('register', {
          url: '/register',
          views: {
            'header': {
              templateUrl: '/templates/partials/header.html'
            },
            'content': {
          controller: 'ListController',
              templateUrl: '/templates/users/new.html'
            }
        }
        })
        .state('profile', {
          url: '/profile',
          views: {
            'header':{
              templateUrl: '/templates/partials/header.html'
            },
            'content':{
              controller: 'profileController',
              templateUrl: '/templates/users/profile.html'
            }
          }
        })
        .state('demo', {
          url: '/demo',
          views: {
            'header':{
              templateUrl: '/templates/partials/header.html'
            },
            'content':{
              controller: 'demoController',
              templateUrl: '/templates/users/demo.html'
            }
          }
        })
        .state('interests', {
          url: '/interests',
          views: {
            'header':{
              templateUrl: '/templates/partials/header.html'
            },
            'content':{
              controller: 'interestsController',
              templateUrl: '/templates/users/interests.html'
            }
          }
        })
        .state('logout',{
          url: '/logout',
          views: {
            'content':{
              controller: 'logoutController'
            }
          }
        })
      }])

    // CONTROLLERS
    .controller('ListController', ['$scope', '$http', function($scope, $http){



        $http({
          method: 'GET',
          dataType: 'json',
          url: 'http://localhost:3000/v1/api/teachers.json'
        }).success(function(data){
          $scope.teachers = data;

        }).error(function(error){
          console.log(error);
        });

    }])

    .controller('MatchesController', ['$scope', '$http', function($scope, $http){

    var item = {}
    item.face = "https://avatars3.githubusercontent.com/u/7256178?v=3&s=460"
    item.who = "Kevin Huang"
    item.notes = "RSpec is a lot of fun."
    item.time = "Thursday"
    var item2 = {}
    item2.face = "https://avatars1.githubusercontent.com/u/14999335?v=3&s=460"
    item2.who = "Monique"
    item2.notes = "Food is amazing"
    item2.time = "Thursday"
    var item3 = {}
    item3.face = "https://i2.wp.com/assets-cdn.github.com/images/gravatars/gravatar-user-420.png?ssl=1"
    item3.who = "Octo Cat"
    item3.notes = "Meow Mother Fucker"
    item3.time = "Thursday"
    var todos = [ item, item2, item3]

    $scope.todos = todos

    }])

    // .controller('ShowController', ['$state', '$stateParams', '$scope', '$http', function($state, $stateParams, $scope, $http){

    //   var teacherId = $stateParams.teacherId
    //   $http({
    //     method: 'GET',
    //     dataType: 'json',
    //     url: 'http://localhost:3000/v1/api/teachers/' + teacherId
    //   }).success(function(data){
    //     $scope.teacher = data
    //   }).error(function(error){
    //     console.log(error);
    //   })

    // }])

    .controller("loginController", ['$scope', '$http', '$window', '$state', function($scope, $http, $window, $state){
      $scope.user = {};
      $scope.processForm= function(){
        $http({
          method: 'POST',
          url: 'http://localhost:3000/api/sessions',
          data: $scope.user
        }).success(function(data){
          $window.sessionStorage.accessToken = data.token;
          $state.go('profile')
        });
      };
    }])

      .controller("profileController", ['$scope', '$http', '$window', function($scope, $http, $window){
        $scope.user = {};
        $http({
          method: 'GET',
          url: 'http://localhost:3000/api/users/profile',
          headers:{Authorization: "Token token=" + $window.sessionStorage.accessToken
          }
        }).success(function(data){
            $scope.user = data
            console.log(data)
        });
    }])

    .controller("demoController", ['$scope', '$http', '$window', '$state', function($scope, $http, $window, $state){
        $scope.user = {};
        $http({
          method: 'GET',
          url: 'http://localhost:3000/api/users/profile',
          headers:{Authorization: "Token token=" + $window.sessionStorage.accessToken
          }
        }).success(function(data){
            $scope.user = data
            console.log(data)
        });
        $scope.processForm= function(){
        $http({
          method: 'PATCH',
          url: 'http://localhost:3000/api/users/' + $scope.user.id,
          data: $scope.user,
          headers:{Authorization: "Token token=" + $window.sessionStorage.accessToken}
        }).success(function(data){
          $state.go('profile')
        });
      };
    }])

    .controller("interestsController", ['$scope', '$http', '$window', function($scope, $http, $window){
        $scope.user = {};
        $http({
          method: 'GET',
          url: 'http://localhost:3000/api/users/profile',
          headers:{Authorization: "Token token=" + $window.sessionStorage.accessToken
          }
        }).success(function(data){
            $scope.user = data
            console.log(data)
        });
    }])

    .controller("logoutController", ['$scope', '$http', '$window', '$state', function($scope, $http, $window, $state){

        $scope.user = {};
        $http({
          method: 'DELETE',
          url: 'http://localhost:3000/api/sessions',
          headers:{Authorization: "Token token=" + $window.sessionStorage.accessToken
          }
        }).success(function(data){
            $window.sessionStorage.removeItem('accessToken');
            console.log($window.sessionStorage.accessToken)
            $state.go('home')
        });
    }])
      ;



})();
