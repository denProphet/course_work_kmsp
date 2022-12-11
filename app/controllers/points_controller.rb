class PointsController < ActionController::Base
  def index
    types = %w[metropolis neumann]
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      types.each { |type|
        points = Point.where("d_type = '#{type}'")
        zos.put_next_entry "#{type}.xlsx"

        zos.print render_to_string(
                    layout: false, handlers: [:axlsx], formats: [:xlsx],
                    template: "points/point",
                    locals: {points: points}
                  )
      }
    end

    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: 'values.zip'
  end
end
