module RBXLBRS
  abstract class Part
    def initialize(@save : BRS::Save, @brick : BRS::Brick)
    end

    # Helper methods

    def rotation : Int32
      value = @brick.rotation.value.to_i32
      case @brick.direction
      when BRS::Direction::XPositive
        value = -value + 2
      when BRS::Direction::XNegative
        value *= -1
      when BRS::Direction::YPositive
        value = -value + 1
      when BRS::Direction::YNegative
        value = -value - 1
      when BRS::Direction::ZPositive
        value *= -1
      when BRS::Direction::ZNegative
        value = -value + 2
      end
      value % 4
    end

    def cframe(apply_angle = true)
      cf = CFrame.new(@brick.position.x / 10, @brick.position.z / 10, @brick.position.y / 10)
      case @brick.direction
      when BRS::Direction::XPositive
        cf *= CFrame.angles(0, 0, -Math::PI / 2)
      when BRS::Direction::XNegative
        cf *= CFrame.angles(0, 0,  Math::PI / 2)
      when BRS::Direction::YPositive
        cf *= CFrame.angles( Math::PI / 2, 0, 0)
      when BRS::Direction::YNegative
        cf *= CFrame.angles(-Math::PI / 2, 0, 0)
      when BRS::Direction::ZPositive
        # do nothing, default direction
      when BRS::Direction::ZNegative
        cf *= CFrame.angles( Math::PI, 0, 0)
      end
      return cf * CFrame.angles(0, rotation * Math::PI / 2, 0) if apply_angle
      return cf
    end

    def write_anchored(xml : XML::Builder, anchored = true)
      xml.element "bool", name: "Anchored" { xml.text anchored.to_s }
    end

    def write_size(xml : XML::Builder, x : Float64, y : Float64, z : Float64)
      xml.element "Vector3", name: "Size" do
        xml.element "X" { xml.text x.to_s }
        xml.element "Y" { xml.text y.to_s }
        xml.element "Z" { xml.text z.to_s }
      end
    end

    def linear_to_srgb(c : Float64)
      c > 0.0031308 ? 1.055 * c ** (1.0 / 2.4) - 0.055 : 12.92 * c
    end

    def write_color(xml : XML::Builder)
      color = @brick.color || @save.colors[@brick.color_index.not_nil!]

      xml.element "Color3", name: "Color" do
        xml.element "R" { xml.text linear_to_srgb(color.r / 255).to_s }
        xml.element "G" { xml.text linear_to_srgb(color.g / 255).to_s }
        xml.element "B" { xml.text linear_to_srgb(color.b / 255).to_s }
      end

      xml.element "float", name: "Transparency" { xml.text (1_f64 - (color.a / 255)).to_s }
    end

    abstract def write_xml(xml : XML::Builder)
  end
end
