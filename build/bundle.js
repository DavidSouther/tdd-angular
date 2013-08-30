;(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function() {
  var todo;

  todo = require("./todo/module.coffee");

}).call(this);


},{"./todo/module.coffee":2}],2:[function(require,module,exports){
(function() {
  var todo;

  module.exports = todo = angular.module("todo", ['ngAnimate']);

  todo.service("storage", function() {
    return {
      get: function() {
        return JSON.parse(window.localStorage["TDD-ToDos"] || '[]');
      },
      put: function(TDs) {
        return window.localStorage["TDD-ToDos"] = JSON.stringify(TDs || []);
      }
    };
  });

  todo.controller("todo", function($scope, storage) {
    var Todos, save;
    $scope.todos = storage.get();
    save = function(newV, oldV) {
      return storage.put($scope.todos);
    };
    $scope.$watch('todos', save, true);
    return Todos = $scope.Todos = {
      current: "",
      add: function() {
        $scope.todos.push(Todos.current);
        return Todos.current = "";
      },
      remove: function(todo) {
        return $scope.todos.splice($scope.todos.indexOf(todo), 1);
      }
    };
  });

}).call(this);


},{}]},{},[1])
//@ sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZ2VuZXJhdGVkLmpzIiwic291cmNlcyI6WyIvaG9tZS9zb3V0aGVyZC9kZXZlbC9zb3V0aGVyZC90ZGQvYW5ndWxhci9zcmMvY2xpZW50L21haW4uY29mZmVlIiwiL2hvbWUvc291dGhlcmQvZGV2ZWwvc291dGhlcmQvdGRkL2FuZ3VsYXIvc3JjL2NsaWVudC90b2RvL21vZHVsZS5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBO0NBQUEsR0FBQSxFQUFBOztDQUFBLENBQUEsQ0FBTyxDQUFQLEdBQU8sZUFBQTtDQUFQOzs7OztBQ0FBO0NBQUEsR0FBQSxFQUFBOztDQUFBLENBQUEsQ0FBaUIsQ0FBQSxFQUFYLENBQU4sSUFBK0M7O0NBQS9DLENBRUEsQ0FBd0IsQ0FBcEIsR0FBSixFQUFBO1dBQ0M7Q0FBQSxDQUFLLENBQUwsR0FBQSxHQUFLO0NBQVEsR0FBRCxDQUFKLENBQWlCLEtBQWMsQ0FBQSxHQUEvQjtDQUFSLE1BQUs7Q0FBTCxDQUNLLENBQUwsR0FBQSxHQUFNO0NBQWMsQ0FBNEIsQ0FBQSxDQUFJLEVBQWpDLEdBQTZCLEVBQWYsQ0FBQSxHQUFwQjtDQURiLE1BQ0s7Q0FGa0I7Q0FBeEIsRUFBd0I7O0NBRnhCLENBTUEsQ0FBd0IsQ0FBcEIsRUFBSixDQUF3QixFQUFDLENBQXpCO0NBQ0MsT0FBQSxHQUFBO0NBQUEsRUFBZSxDQUFmLENBQUEsQ0FBTSxDQUFnQjtDQUF0QixDQUNjLENBQVAsQ0FBUCxLQUFRO0NBQ0MsRUFBUixFQUFBLENBQWtCLENBQVgsTUFBUDtDQUZELElBQ087Q0FEUCxDQUd1QixFQUF2QixFQUFNLENBQU47Q0FDZSxFQUFQLEVBQVIsQ0FBYyxLQUFkO0NBQ0MsQ0FBUyxJQUFULENBQUE7Q0FBQSxDQUNLLENBQUwsR0FBQSxHQUFLO0NBQ0osR0FBQSxDQUFZLENBQU4sQ0FBTixDQUFBO0NBQ00sRUFBVSxFQUFYLEVBQUwsUUFBQTtDQUhELE1BQ0s7Q0FETCxDQUlRLENBQUEsQ0FBQSxFQUFSLEdBQVM7Q0FDRCxDQUF5QyxFQUE1QixDQUFSLENBQU4sQ0FBYyxRQUFwQjtDQUxELE1BSVE7Q0FWYztDQUF4QixFQUF3QjtDQU54QiIsInNvdXJjZXNDb250ZW50IjpbInRvZG8gPSByZXF1aXJlIFwiLi90b2RvL21vZHVsZS5jb2ZmZWVcIlxuIiwibW9kdWxlLmV4cG9ydHMgPSB0b2RvID0gYW5ndWxhci5tb2R1bGUgXCJ0b2RvXCIsIFsnbmdBbmltYXRlJ11cblxudG9kby5zZXJ2aWNlIFwic3RvcmFnZVwiLCAtPlxuXHRnZXQ6IC0+IEpTT04ucGFyc2Ugd2luZG93LmxvY2FsU3RvcmFnZVtcIlRERC1Ub0Rvc1wiXSB8fCAnW10nXG5cdHB1dDogKFREcyktPiB3aW5kb3cubG9jYWxTdG9yYWdlW1wiVERELVRvRG9zXCJdID0gSlNPTi5zdHJpbmdpZnkgVERzIHx8IFtdXG5cbnRvZG8uY29udHJvbGxlciBcInRvZG9cIiwgKCRzY29wZSwgc3RvcmFnZSktPlxuXHQkc2NvcGUudG9kb3MgPSBzdG9yYWdlLmdldCgpXG5cdHNhdmUgPSAobmV3Viwgb2xkVikgLT5cblx0XHRzdG9yYWdlLnB1dCAkc2NvcGUudG9kb3Ncblx0JHNjb3BlLiR3YXRjaCAndG9kb3MnLCBzYXZlLCB0cnVlXG5cdFRvZG9zID0gJHNjb3BlLlRvZG9zID1cblx0XHRjdXJyZW50OiBcIlwiXG5cdFx0YWRkOiAtPlxuXHRcdFx0JHNjb3BlLnRvZG9zLnB1c2ggVG9kb3MuY3VycmVudFxuXHRcdFx0VG9kb3MuY3VycmVudCA9IFwiXCJcblx0XHRyZW1vdmU6ICh0b2RvKS0+XG5cdFx0XHQkc2NvcGUudG9kb3Muc3BsaWNlICRzY29wZS50b2Rvcy5pbmRleE9mKHRvZG8pLCAxXG4iXX0=
;