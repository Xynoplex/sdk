module WrongHttpAnswer where
import Xynoplex.Gateway (GatewayOperations, healthCheck)
import Xynoplex.Types (UserResponse)
wrong :: GatewayOperations -> IO UserResponse
wrong = healthCheck
