module WrongHttpAnswer where
import Xynolog.Gateway (GatewayOperations, healthCheck)
import Xynolog.Types (UserResponse)
wrong :: GatewayOperations -> IO UserResponse
wrong = healthCheck
