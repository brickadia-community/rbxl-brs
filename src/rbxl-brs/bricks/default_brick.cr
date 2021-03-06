module RBXLBRS
  class DefaultBrick < Part
    def write_xml(xml : XML::Builder)
      xml.element "Item", {"class" => "Part"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @brick.size.x / 5, @brick.size.z / 5, @brick.size.y / 5)
          cframe.write_xml(xml)
          write_color(xml)
          write_material(xml)
        end
      end
    end
  end
end
