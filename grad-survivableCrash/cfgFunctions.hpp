class grad_survivableCrash {

    class client {
          file = grad-survivableCrash\functions\client;

          class onCrashLocal;
  };

    class server {
          file = grad-survivableCrash\functions\server;

          class addHandler;
          class autoInit { postInit = 1; };
          class onCrash;
          class spawnHolder;
          class throwOutInventory;
  };
};