module RBXLBRS
  struct CFrame
    macro component(name, default)
      getter {{name}} : Float64 = {{default}}_f64
    end

    component x, 0
    component y, 0
    component z, 0

    component m00, 1
    component m01, 0
    component m02, 0
    component m10, 0
    component m11, 1
    component m12, 0
    component m20, 0
    component m21, 0
    component m22, 1

    # Create a CFrame at the origin with no rotation.
    def initialize
    end

    # Create a CFrame at a specific point with no rotation.
    def initialize(@x, @y, @z)
    end

    # Create a CFrame at a specific Vector3 with no rotation.
    def initialize(v : BRS::Vector3)
      @x = v.x
      @y = v.y
      @z = v.z
    end

    # Create a CFrame, given each component (x, y, z, m00, m01, m02, m10, m11, m12, m20, m21, m22).
    def initialize(@x, @y, @z, @m00, @m01, @m02, @m10, @m11, @m12, @m20, @m21, @m22)
    end

    # Create a CFrame from an array representing a 4x4 matrix.
    def initialize(array : Array(Float64))
      @m00 = array[0]
      @m01 = array[1]
      @m02 = array[2]
      @x = array[3]
      @m10 = array[4]
      @m11 = array[5]
      @m12 = array[6]
      @y = array[7]
      @m20 = array[8]
      @m21 = array[9]
      @m22 = array[10]
      @z = array[11]
    end

    # Create a CFrame from an array of arrays representing a 4x4 matrix.
    def initialize(array : Array(Array(Float64)))
      initialize array.flatten
    end

    # Create a CFrame from Euler angles.
    def self.angles(rx, ry, rz)
      CFrame.new(0_f64, 0_f64, 0_f64, Math.cos(rz), -Math.sin(rz), 0_f64, Math.sin(rz), Math.cos(rz), 0_f64, 0_f64, 0_f64, 1_f64) *
      CFrame.new(0_f64, 0_f64, 0_f64, Math.cos(ry), 0_f64, Math.sin(ry), 0_f64, 1_f64, 0_f64, -Math.sin(ry), 0_f64, Math.cos(ry)) *
      CFrame.new(0_f64, 0_f64, 0_f64, 1_f64, 0_f64, 0_f64, 0_f64, Math.cos(rx), -Math.sin(rx), 0_f64, Math.sin(rx), Math.cos(rx))
    end

    # Return a tuple of the components.
    def components
      {@m00, @m01, @m02, @x, @m10, @m11, @m12, @y, @m20, @m21, @m22, @z, 0_f64, 0_f64, 0_f64, 1_f64}
    end

    # Return an array of 4 arrays representing the rows of the components.
    def rowed_components
      [[@m00, @m01, @m02, @x], [@m10, m11, m12, @y], [@m20, @m21, @m22, @z], [0_f64, 0_f64, 0_f64, 1_f64]]
    end

    # Multiplies two CFrames together (multiplies their matrices).
    def *(other : CFrame)
      a = rowed_components
      b = other.rowed_components
      o = [[0_f64, 0_f64, 0_f64, 0_f64], [0_f64, 0_f64, 0_f64, 0_f64], [0_f64, 0_f64, 0_f64, 0_f64], [0_f64, 0_f64, 0_f64, 0_f64]]
      4.times do |i|
        4.times do |j|
          4.times do |k|
            o[i][j] += a[i][k] * b[k][j]
          end
        end
      end
      CFrame.new(o)
    end

    # Write the CFrame out to an `XML::Builder`.
    def write_xml(xml : XML::Builder, name = "CFrame")
      xml.element "CoordinateFrame", name: name do
        xml.element "X" { xml.text @x.to_s }
        xml.element "Y" { xml.text @y.to_s }
        xml.element "Z" { xml.text @z.to_s }

        xml.element "R00" { xml.text @m00.to_s }
        xml.element "R01" { xml.text @m01.to_s }
        xml.element "R02" { xml.text @m02.to_s }
        xml.element "R10" { xml.text @m10.to_s }
        xml.element "R11" { xml.text @m11.to_s }
        xml.element "R12" { xml.text @m12.to_s }
        xml.element "R20" { xml.text @m20.to_s }
        xml.element "R21" { xml.text @m21.to_s }
        xml.element "R22" { xml.text @m22.to_s }
      end
    end
  end
end
