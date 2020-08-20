module RBXLBRS
  class DefaultRamp < Part
    def write_xml(xml : XML::Builder)
      xml.element "Item", {"class" => "Part"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @brick.size.y / 5, @brick.size.z / 5, 1_f64)
          (cframe(apply_angle: false) * CFrame.angles(0, (rotation - 1) * Math::PI / 2, 0) * CFrame.new(0_f64, 0_f64, @brick.size.x / 10 - 0.5)).write_xml(xml)
          write_color(xml)
        end
      end

      xml.element "Item", {"class" => "WedgePart"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @brick.size.y / 5, @brick.size.z / 5, @brick.size.x / 5 - 1)
          (cframe(apply_angle: false) * CFrame.angles(0, (rotation - 1) * Math::PI / 2, 0) * CFrame.new(0_f64, 0_f64, -0.5)).write_xml(xml) # 3 - rotation
          write_color(xml)
        end
      end
    end
  end
end
