module RBXLBRS
  class DefaultRampInnerCorner < Part
    def write_xml(xml : XML::Builder)
      xml.element "Item", {"class" => "Part"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, 1.0, @brick.size.z / 5, @brick.size.x / 5)
          (cframe(apply_angle: false) * CFrame.angles(0, (rotation - 1) * Math::PI / 2, 0) * CFrame.new(@brick.size.y / -10 + 0.5, 0.0, 0.0)).write_xml(xml)
          write_color(xml)
          write_material(xml)
        end
      end

      xml.element "Item", {"class" => "Part"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @brick.size.y / 5, @brick.size.z / 5, 1.0)
          (cframe(apply_angle: false) * CFrame.angles(0, (rotation - 1) * Math::PI / 2, 0) * CFrame.new(0.0, 0.0, @brick.size.x / 10 - 0.5)).write_xml(xml)
          write_color(xml)
          write_material(xml)
        end
      end

      xml.element "Item", {"class" => "WedgePart"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @brick.size.x / 5 - 1, @brick.size.z / 5, @brick.size.y / 5 - 1)
          (cframe(apply_angle: false) * CFrame.angles(0, (rotation - 1) * Math::PI / 2, 0) * CFrame.new(0.5, 0.0, -0.5) * CFrame.angles(0.0, -Math::PI / 2, 0.0)).write_xml(xml)
          write_color(xml)
          write_material(xml)
        end
      end

      xml.element "Item", {"class" => "WedgePart"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @brick.size.y / 5 - 1, @brick.size.z / 5,  @brick.size.x / 5 - 1)
          (cframe(apply_angle: false) * CFrame.angles(0, (rotation - 1) * Math::PI / 2, 0) * CFrame.new(0.5, 0.0, -0.5) * CFrame.angles(0.0, 0, 0.0)).write_xml(xml)
          write_color(xml)
          write_material(xml)
        end
      end
    end
  end
end
