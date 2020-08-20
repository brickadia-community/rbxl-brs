module RBXLBRS
  class SpawnPoint < Part
    def write_xml(xml : XML::Builder)
      xml.element "Item", {"class" => "SpawnLocation"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, 4.0, 0.4, 4.0)
          cframe.write_xml(xml)
          write_color(xml)
        end
      end
    end
  end
end
