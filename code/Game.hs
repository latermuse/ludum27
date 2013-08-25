import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT
import Bindings
import Data.IORef

main = do
  initialWindowSize $= Size 500 500
  (progname,_) <- getArgsAndInitialize
  initialDisplayMode $= [RGBMode, WithDepthBuffer, DoubleBuffered]
  createWindow "Epic Game"
  reshapeCallback $= Just reshape
  depthFunc $= Just Less
  angle <- newIORef 0.0
  delta <- newIORef (0.1::GLfloat)
  position <- newIORef (0.0::GLfloat, 0.0)
  keyboardMouseCallback $= Just (keyboardMouse delta position)
  idleCallback $= Just (idle angle delta)
  displayCallback $= (display angle position)
  --lighting $= Enabled --??
  mainLoop

