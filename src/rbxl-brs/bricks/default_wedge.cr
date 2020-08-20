module RBXLBRS
  class DefaultWedge < Part
    def write_xml(xml : XML::Builder)
      xml.element "Item", {"class" => "WedgePart"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @brick.size.y / 5, @brick.size.z / 5, @brick.size.x / 5)
          (cframe(apply_angle: false) * CFrame.angles(0, (rotation - 1) * Math::PI / 2, 0)).write_xml(xml) # 3 - rotation
          write_color(xml)
        end
      end
    end
  end
end
