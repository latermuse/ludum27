module Display (display,idle) where
import Data.IORef
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT
import Cube
import Points
 

display angle position = do

  clear [ColorBuffer,DepthBuffer]
  loadIdentity
  (x,y) <- get position
  translate $ Vector3 x y 0
  preservingMatrix $ do
    a <- get angle
    rotate a $ Vector3 0.3 0.1 (1::GLfloat)
    scale 0.3 0.3 (0.3::GLfloat)
    mapM_ (\(x,y,z) -> preservingMatrix $ do
                              color $ Color3 ((x + 2.0) / 3.0) ((y + 2.0) / 3.0) ((z + 2.0) / 3.0)
                              translate $ Vector3 x y z
                              cube (0.2::GLfloat)
                              color $ Color3 (0.0::GLfloat) (0.0::GLfloat) (0.0::GLfloat) --set outline color to black
                              cubeFrame (0.2::GLfloat) --draw the outline
                              ) (points 10)

    rotate a $ Vector3 0 0.5 (1::GLfloat)
    mapM_ (\(x,y,z) -> preservingMatrix $ do
                              color $ Color3 ((x + 1.0) / 2.0) ((y + 1.0) / 2.0) ((z + 1.0) / 2.0)
                              translate $ Vector3 x y z
                              cube (0.1::GLfloat)
                              color $ Color3 (4.0::GLfloat) (0.0::GLfloat) (0.0::GLfloat) --set outline color to black
                              cubeFrame (0.1::GLfloat) --draw the outline
                              ) (points 30)

  swapBuffers
      

idle angle delta = do
  a <- get angle
  d <- get delta
  angle $= a + d
  postRedisplay Nothing


